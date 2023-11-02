# Stable RSpec Profile

Run `rspec --profile` multiple times, averaging the results.


## Why?

I have a hard time getting predictable `--profile` info for my Rails app with 750 tests. Every time
I run it, I get different results. I think it's because of class load order changing and test http
startup. The specs that run first seem to take the longest.

This script works around these issues—making the output stable—by running `rspec --profile` many times and
averaging the results.


## Installation

```bash
gem install stable_profile
```

## Usage

```bash
$ stable-profile help profile
Usage:
  stable-profile profile

Options:
  -i, [--iterations=N]            # Number of times to run RSpec
                                  # Default: 20
  -t, [--top-slowest-examples=N]  # Number of slowest examples to output
                                  # Default: 5

Run RSpec profile multiple times, averaging the results.


$ stable-profile profile -i 5 -t 5
Running profiles: |=====================================================================================| 100% Time: 00:00:32

Top 5 slowest examples:
  Search request when called via a spider is handled gracefully
    0.548 seconds  (N=5)  ./spec/requests/search_requests_spec.rb:7
  Search request noindex is implemented on a search page
    0.5382 seconds (N=5)  ./spec/requests/search_requests_spec.rb:16
  Subscriptions Ad visibility when signed in and manually verified does NOT show ads on the Sec. Srcs. page
    0.2092 seconds (N=5)  ./spec/features/accounts/subscription_spec.rb:79
  Error handling URLs that used to crash the server does not crash.
    0.1972 seconds (N=5)  ./spec/requests/errors_spec.rb:12
  Subscriptions Ad visibility when signed in and manually verified
    0.1861 seconds (N=5)  ./spec/features/accounts/subscription_spec.rb:64

Top 5 slowest example groups:
  Search request
    1.1119 seconds (N=5)  ./spec/requests/search_requests_spec.rb:5
  Subdomain Selection
    0.8351 seconds (N=5)  ./spec/features/basic_site_functions/subdomain_selection_nevada_spec.rb:5
  Subdomain Selection
    0.7707 seconds (N=5)  ./spec/features/basic_site_functions/subdomain_selection_newyork_spec.rb:5
  Subdomain Selection
    0.723 seconds  (N=5)  ./spec/features/basic_site_functions/subdomain_selection_texas_spec.rb:5
  Dictionary
    0.1959 seconds (N=5)  ./spec/features/basic_site_functions/dictionary_spec.rb:5

```

I get the above output every time I run stable-profile; that's the real added value of this gem.



## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
