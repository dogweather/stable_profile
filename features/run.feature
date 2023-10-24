Feature: Run
  In order to execute the profiler
  As a CLI
  I want an easy UX.

  Scenario: Requesting help
    When I run `stable-profile --help`
    Then the output should contain "Commands:"
