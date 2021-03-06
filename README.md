DIESELUP [![Build Status](https://travis-ci.org/xcopy/dieselup-ruby.svg?branch=master)](https://travis-ci.org/xcopy/dieselup-ruby) [![Gem Version](https://badge.fury.io/rb/dieselup.svg)](https://badge.fury.io/rb/dieselup)
========

System requirements
-------------------

* *nix
* Git
* RVM

Usage
-----

Developers:

```shell
$ cd
$ git clone git@github.com:xcopy/dieselup-ruby.git dieselup
$ cd dieselup
$ bundle
$ USERNAME=your-username PASSWORD=your-password bundle exec bin/dieselup <your-topic-ID>
```

Common users:

```shell
$ gem install dieselup --no-ri --no-rdoc
$ USERNAME=your-username PASSWORD=your-password dieselup <your-topic-ID>
```

Cron task example:

```shell
USERNAME=your-username
PASSWORD=your-password
...
*/1 * * * * dieselup <your-topic-ID> > /dev/null 2>&1
```

That's it!

Like PHP?
---------

Sweet. Check out [PHP dieselup](https://github.com/xcopy/dieselup) 

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
