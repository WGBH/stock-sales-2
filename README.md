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

### Video Clips

For clips described in the Filemaker database, the essence video file is ingested into the WGBH Stock Sales Sony Ci account.  There, the essence files are hosted and lower-resolution versions are created automatically and used by the website.  Files should be named the same as their id value found in the stock-sales-loose Filemaker database.

### Ingesting Into Sony Ci

We are using [Sony Ci](http://developers.cimediacloud.com) to host the video and audio files.
In the office we are using the Ci API to upload content, and on the server the API
is used to generate transient download URLs. On either end, an additional 
git-ignored configuration file (`config/ci.yml`) is necessary.

```yaml
username: [your ci username]
password: [your ci password]
client_id: [32 character hexadecimal client ID]
client_secret: [32 character hexadecimal client secret]
workspace_id: [32 character hexadecimal workspace ID]
```

Use your personal workspace ID if you are working on the Ci code itself, or the 
AAPB workspace ID if you want to view media that is stored.

To actually ingest:

Ingest from the command line should be done when you have multiple files you would like to upload.
If you only have a file or two you would like to ingest, you can also use the [Sony Ci webite] (https://workspace.cimediacloud.com/account/login) directly.
Make sure you have Ruby and rvm installed.

```bash
$ cd /PATH/TO/stock-sales-2
$ echo /PATH/TO/FILES/* | xargs -n 10 ruby scripts/ci/ci.rb --log ~/ci_log.csv --up
$ # A big directory may have more files than ruby can accommodate as arguments, so xargs
$ tail -f ~/ci_log.csv
$ # Use tail to monitor the writing of the log file
```
After the ingest process is complete, review the ci_log.csv document and check that all the files were sucessfully ingested.  All the files should have a unique Ci-ID value.  If some files failed to upload, place them in their own folder and re-run the command line process.
You should also check the [Sony Ci webite] (https://workspace.cimediacloud.com/account/login) after ingest to make sure no files have a "Failed" status.  This isn't always obvious in the ci_log.csv file.  If a file is listed as "Failed" delete it from the Ci website and reingest either from the command line or the website interface.

Once all the files have been successfully ingested, open the WGBH hosted Filemaker databse, stock-sales-loose, and create or update the video clip records with their new Sony Ci-ID values.  These are found either in the ci_log.csv file if you used the command line to ingest, or they can be found by using the Sony Ci website.

### Thumbnails

These are created automatically within Sony Ci and available via the API.

### Downloadable Clips

For every video clip available to view on the site, a WGBH watermarked downloadable version is also available.  These files are created outside of the Sony Ci ingest workflow and are hosted on the Stock Sales Amazon S3 instance.  These downloadable clip files should be named the same as the essence files they are created from.  We're currently using Sorenson Squeeze to transcode.
Watermarked video specs: H.264 codec, 360x240 resolution, 15 fps, Transparent "WGBH Stock Sales" watermark

## Uploading to Amazon S3

You can use the AWS web interface to upload watermarked files, or collection images to the Stock Sales website but for uploading multiple files you should use the Amazon CLI tool.  The transfer speed is a lot faster and large transfers shouldn't time out.

[Follow the documentation](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) to set up CLI with your Access Key, Secret Access Key, and Default region name.

The buckets are located under **/content/**

- /collections/ is for image thumbnails for all the various collections
- /watermarked_clips/ is for the .mov watermarked video clips that are available to be downloaded


Copy Directory of Files to S3:
```
aws s3 cp /local/folder/of/stuff s3://wgbhstocksales.org/bucket-name -- recursive
```

Double Check Files Were Uploaded:
```
aws s3 ls s3://wgbhstocksales.org/bucket-name --recursive >> /Users/logs/s3_proxies.csv
```
