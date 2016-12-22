class PaymentsJs
  require 'openssl'
  require 'base64'
  require 'json'
  require 'yaml'

  # Generate a salt
  def generate_salt(iv)
    salt = iv.unpack('H*').first
    salt = salt.bytes.to_a
    salt = salt.pack('U*')
    Base64.strict_encode64(salt)
  end

  attr_accessor :address, :city, :state, :zip, :amount, :request_id, :name, :request_type, :pre_auth, :environment, :api_key, :salt, :mid, :postback_url, :auth_key

  def initialize(args = {})
    payment_creds = YAML.load_file(Rails.root + 'config/payments_js.yml')

    @api_key      = payment_creds['api_key']
    @mid          = payment_creds['mid']
    @mkey         = payment_creds['mkey']
    @api_secret   = payment_creds['api_secret']

    @request_type = args[:request_type].present? ? args[:request_type] : 'payment'
    @request_id   = args[:request_id]
    @postback_url = args[:postback_url].present? ? args[:postback_url] : 'https://www.example.com'
    @amount       = args[:amount]
    @pre_auth     = args[:pre_auth].present? ? args[:pre_auth] : false
    @environment  = args[:environment].present? ? args[:environment] : 'cert'

    # Generate the salt and iv at initialization so they can be consistently called
    @iv = OpenSSL::Random.pseudo_bytes(16)
    @salt = generate_salt(@iv)

  end

  def get_auth_key
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt

    req  = {
      "apiKey"      => @api_key,
      "merchantId"  => @mid,
      "merchantKey" => @mkey,
      "requestType" => @request_type,
      "requestId"   => @request_id,
      "postbackUrl" => @postback_url,
      "amount"      => @amount,
      "nonce"       => @salt,
      "preAuth"     => @pre_auth,
      "environment" => @environment
    }

    data       = JSON.generate(req)
    key        = OpenSSL::PKCS5.pbkdf2_hmac_sha1(@api_secret, @salt, 1500, 32)
    cipher.key = key
    cipher.iv  = @iv
    auth_key    = cipher.update(data) + cipher.final()

    Base64.strict_encode64(auth_key)
  end

  def get_salt
    @salt
  end
end
