serum-rails
===========

Code scanner to prepare security audits
---------------------------------------

When you inquire about the cost of a security audit at [makandra](http://www.makandra.com)
we will ask you to provide some metrics about your application, like the number of controller actions
and many others.

This gem provides a `serum-rails` command you can use to scan your project and
provide these metrics automatically. By sending us the output of the `serum-rails` command
we can give you an recommendation for the time you should invest for a security audit.

Since all you send us are a few numbers, we don't need to look at your code for a first
estimate. This saves us signing an NDA and giving us access to your repository before
we even work together.

### Prerequisites

You need:

- Ruby 1.8.7 or higher
- [Bundler](http://bundler.io/)
- A machine that can run the project you want to generate metrics for. `serum-rails` will call `bundle` and `rake`
  inside your project directory, so make sure you have a `database.yml` and all dependencies installed.
  If you can open a Rails console you should be good to go.

### Installation

You can install `serum-rails` as a Ruby gem:

```
gem install serum-rails
```

Once you have installed the gem you should have a `serum-rails` command in your path.

### Usage

Start serum-rails like this:

```
serum-rails PATH_TO_YOUR_RAILS_APPLICATION
```

`serum-rails` will scan the code of your application and output some code metric to the console.
It should look like this:

```
time = 2014-09-04 11:25:44
routes = 243
file_accesses = 66
controller_methods = 135
mailer_invocations = 17
uploaders = 5
redirects = 33
crypto_terms = 42
json_outputs = 0
cookie_accesses = 7
yaml_inputs = 0
unescaped_strings = 59
lines_of_code = 42784
gems = 154
```

Please e-mail the output to your security audit contact at makandra to continue the process.
