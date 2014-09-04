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

Please e-mail the output to your security audit contact at makandra to continue the process.
