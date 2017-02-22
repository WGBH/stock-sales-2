class PaymentsJs
  require 'openssl'
  require 'base64'
  require 'json'

  attr_accessor :address, :city, :state, :zip, :amount, :order_number, :name, :request_type, :pre_auth, :environment, :client_id, :client_secret, :salt, :mid, :mkey, :postback_url, :email, :description, :wgbh_phone, :wgbh_email, :auth_key, :fake_data

  def initialize(args = {})
    @mid            = ENV['SAGE_MID'].try(:to_s)
    @mkey           = ENV['SAGE_MKEY'].try(:to_s)
    @client_id      = ENV['SAGE_CLIENT_ID'].try(:to_s)
    @client_secret  = ENV['SAGE_CLIENT_SECRET'].try(:to_s)

    @request_type = 'payment'
    @pre_auth     = 'false'
    @environment  = get_environment
    @fake_data    = fake_data?(@environment)

    @order_number = args[:order_number].present? ? args[:order_number] : nil
    @amount       = args[:amount].present? ? args[:amount] : nil
    @name         = args[:name].present? ? args[:name] : nil
    @address      = args[:address].present? ? args[:address] : nil
    @city         = args[:city].present? ? args[:city] : nil
    @state        = args[:state].present? ? args[:state] : nil
    @zip          = args[:zip].present? ? args[:zip] : nil
    @email        = args[:email].present? ? args[:email] : nil
    @description  = args[:description].present? ? args[:description] : nil
    @wgbh_phone   = args[:wgbh_phone].present? ? args[:wgbh_phone] : WgbhStocksales::PHONE
    @wgbh_email   = args[:wgbh_email].present? ? args[:wgbh_email] : WgbhStocksales::EMAIL

    @iv = OpenSSL::Random.pseudo_bytes(16)
    @salt = generate_salt(@iv)
    @auth_key = get_auth_key
  end

  def pay_js_ui_attributes
    {
      clientId: @client_id,
      merchantId: @mid,
      requestType: @request_type,
      orderNumber: @order_number,
      amount: @amount,
      authKey: @auth_key,
      salt: @salt,
      elementId: "paymentDiv",
      debug: "true",
      preAuth: @pre_auth,
      addFakeData: @fake_data,
      environment: @environment,
      billing: {
        name: @name,
        address: @address,
        city: @city,
        state: @state,
        postalCode: @zip
      }
    }
  end

  def self.check_result?(result)
    json_result = JSON.parse(result)
    payload = JSON.generate(json_result["Response"])
    calc_hash = Base64.strict_encode64(
      OpenSSL::HMAC.digest('sha512', ENV['SAGE_CLIENT_SECRET'], payload)
      ).gsub('+', ' ')
    result_hash = json_result["Hash"]

    calc_hash == result_hash
  end

  private

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

  def generate_salt(iv)
    salt = iv.unpack('H*').first
    salt = salt.bytes.to_a
    salt = salt.pack('U*')
    Base64.strict_encode64(salt)
  end

  def get_environment
    return 'cert' if Rails.env.development? || Rails.env.test?
    return 'prod' if Rails.env.production?
  end

  def fake_data?(environment)
    return 'true' if environment == 'cert'
    'false'
  end
end
