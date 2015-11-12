[![Build Status](https://travis-ci.org/WGBH/stock-sales-2.svg?branch=master)](https://travis-ci.org/WGBH/stock-sales-2)

# stock-sales-2

WGBH Stock Sales: http://wgbhstocksales.org/

The design of this site was guided by the realization that the clips just won't be the answer to most questions:
We need to suggest the range of resources WGBH offers and get folks off on the right foot by just encouraging
them to contact us.

## Development

```bash
git clone git@github.com:WGBH/stock-sales-2.git
cd stock-sales-2
rake jetty:config
rake jetty:start
ruby scripts/lib/ingester.rb spec/fixtures/fm-export-results.xml
# Or if you have exported from Filemaker locally:
# ruby scripts/lib/ingester.rb /tmp/fm-export.xml
rails server
```

## Production

Initial server setup has not been well-defined, though redeply and reindex are: The scripts run by Filemaker require that you have `stock-sales.pem` in place.

### Reindex

The backing database for the clips is a WGBH-hosted Filemaker database. It provides a script which exports the records, scps them to the server, and sshs to the server to run the ingest script.

### Redeploy

The Filemaker database also has a script for redeploys. It does not actually depend on any information from the database: It's just a convenient place to put the script.

### Thumbnails

TODO
