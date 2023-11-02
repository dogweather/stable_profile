Feature: Run
  In order to execute the profiler
  As a CLI
  I want an easy UX.

  Scenario: Requesting help
    When I run `stable-profile --help`
    Then the output should contain "Commands:"

  Scenario: Requesting help for profile
    When I run `stable-profile help profile`
    Then the output should contain "iterations"

  Scenario: Running multi-profile
    When I run `stable-profile`
    Then the output should contain "Top 5 slowest examples"
