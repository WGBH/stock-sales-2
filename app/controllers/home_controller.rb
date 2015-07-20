class HomeController < ApplicationController
  def index
    @collections = [
      {name: 'NOVA', href: '/collections/nova', img_src: 'http://placehold.it/269x151'},
      {name: 'Frontline', href: '/collections/frontline', img_src: 'http://placehold.it/269x151'},
      {name: 'American Experience', href: '/collections/amex', img_src: 'http://placehold.it/269x151'},
      {name: 'TBD', href: '/collections/tbd', img_src: 'http://placehold.it/269x151'},
      {name: 'TBD', href: '/collections/tbd', img_src: 'http://placehold.it/269x151'},
      {name: 'TBD', href: '/collections/tbd', img_src: 'http://placehold.it/269x151'},
      {name: 'TBD', href: '/collections/tbd', img_src: 'http://placehold.it/269x151'},
      {name: 'TBD', href: '/collections/tbd', img_src: 'http://placehold.it/269x151'},
      {name: 'TBD', href: '/collections/tbd', img_src: 'http://placehold.it/269x151'}
    ]
  end
end
