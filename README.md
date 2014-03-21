# Rexis - a central registry for private sharing of URLs

Simple Sinatra/Sequel application that allows an app to privately
distribute access to a resource (URL) to users.

The registry (rexis server) accepts a URL from an app and generates a
substitute URL in return. That URL can be distributed to users. When a
user presents the substitute URL, they receive a code which can be
presented back to the app to establish resource access.

## Installation

Use bundler, or

    $ gem install rexis

Edit the `.env` file (or `.development.env` or `.test.env`) and
provide values for the following:

`DATABASE_URL`: location of database used by Sequel (has only been
tested so far with PostgreSQL)

`REXIS_DOMAIN`: Domain name used for all generated Rexis URLs


## Usage

A `config.ru` is provided to operate under Rack, for example:

    $ rackup

## API

`POST` to `{REXIS_DOMAIN}` to register a resource: payload
must include `url` parameter; response is a JSON hash with a single
`registry_url` value.

`GET {REGISTRY_URL}`: retrieve unique code for the registered resource

## TODO

* Token and code expiration
* Limit number of participants
* Registered payload could include other attributes besides URL

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
