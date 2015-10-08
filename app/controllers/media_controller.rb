class MediaController < ApplicationController
  include Blacklight::Catalog

  def show
    _response, document = fetch(params['id'])
    json = document.instance_variable_get('@_source')['json']
    asset = Asset.new(JSON.parse(json))

    if current_user.stock_sales_referer?
      ci = SonyCiBasic.new(credentials_path: Rails.root + 'config/ci.yml')
      # OAuth credentials expire: otherwise it would make sense to cache this instance.
      redirect_to ci.download(asset.ci_id)
    else
      render nothing: true, status: :unauthorized
    end
  end
end
