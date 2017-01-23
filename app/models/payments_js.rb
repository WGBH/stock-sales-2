class PaymentsJs
  require 'openssl'
  require 'base64'
  require 'json'
  require 'yaml'

  attr_accessor :address, :city, :state, :zip, :amount, :order_number, :name, :request_type, :pre_auth, :environment, :client_id, :client_secret, :salt, :mid, :mkey, :postback_url, :email, :description

  # Generate a salt
  def generate_salt(iv)
    salt = iv.unpack('H*').first
    salt = salt.bytes.to_a
    salt = salt.pack('U*')
    Base64.strict_encode64(salt)
  end

  def initialize(args = {})
    payment_creds = YAML.load_file(Rails.root + 'config/payments_js.yml')

    @mid            = payment_creds['mid'].try(:to_s)
    @mkey           = payment_creds['mkey'].try(:to_s)
    @client_id      = payment_creds['client_id'].try(:to_s)
    @client_secret  = payment_creds['client_secret'].try(:to_s)

    @request_type = args[:request_type].present? ? args[:request_type] : 'payment'
    @order_number = args[:order_number]
    # @postback_url = args[:postback_url].present? ? args[:postback_url] : 'https://www.example.com'
    @amount       = args[:amount]
    @pre_auth     = args[:pre_auth].present? ? args[:pre_auth].try(:to_s) : false
    @environment  = args[:environment].present? ? args[:environment] : 'cert'
    @name         = args[:name].present? ? args[:name] : nil
    @address      = args[:address].present? ? args[:address] : nil
    @city         = args[:city].present? ? args[:city] : nil
    @state        = args[:state].present? ? args[:state] : nil
    @zip          = args[:zip].present? ? args[:zip] : nil
    @email        = args[:email].present? ? args[:email] : nil
    @description  = args[:description].present? ? args[:description] : nil
    # Generate the salt and iv at initialization so they can be consistently called
    @iv = OpenSSL::Random.pseudo_bytes(16)
    @salt = generate_salt(@iv)
  end

  def get_auth_key
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt

    req  = {
      "clientId"    => @client_id,
      "merchantId"  => @mid,
      "merchantKey" => @mkey,
      "requestType" => @request_type,
      "orderNumber" => @order_number,
      "amount"      => @amount,
      "salt"        => @salt,
      "preAuth"     => @pre_auth,
      "environment" => @environment
    }

    data       = JSON.generate(req)
    key        = OpenSSL::PKCS5.pbkdf2_hmac_sha1(@client_secret, @salt, 1500, 32)
    cipher.key = key
    cipher.iv  = @iv
    auth_key   = cipher.update(data) + cipher.final()

    Base64.strict_encode64(auth_key)
  end

  def get_salt
    @salt
  end
end
