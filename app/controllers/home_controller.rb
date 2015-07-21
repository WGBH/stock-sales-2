class HomeController < ApplicationController
  def index
    img_src = 'http://placehold.it/272x152'
    @collections = [
      {name: 'NOVA', href: '/collections/nova', img_src: img_src},
      {name: 'Frontline', href: '/collections/frontline', img_src: img_src},
      {name: 'American Experience', href: '/collections/amex', img_src: img_src},
      {name: 'TBD', href: '/collections/tbd', img_src: img_src},
      {name: 'TBD', href: '/collections/tbd', img_src: img_src},
      {name: 'TBD', href: '/collections/tbd', img_src: img_src},
      {name: 'TBD', href: '/collections/tbd', img_src: img_src},
      {name: 'TBD', href: '/collections/tbd', img_src: img_src},
      {name: 'TBD', href: '/collections/tbd', img_src: img_src}
    ]
  end
end
