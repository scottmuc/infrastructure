# Mucrastructure

## This Repository Contains

* [DNS](dns/) automation for all my domains
* [Raspberry Pi Configuration Management](pi/) which performs the following: dhcpd, ad blocking dns, music service, monitoring
* [Homedir configuration](homedirs) for WSL, Windows, Ubuntu, and macOS
* [Repaving instructions](.github/ISSUE_TEMPLATE) for all platforms

### Coding Conventions

* `bash` - Following the [Google][google-bash] styleguide as much as I can. The [Chromium][chrome-bash] and [Apple][apple-bash] styleguides are also useful.
* `ansible` - I Really like [this post][ansible-standards] on some basic standards.
* `powershell` - [PoshCode][poshcode] seems like a pretty good baseline.

[ansible-standards]: https://www.ansiblejunky.com/blog/ansible-101-standards/
[google-bash]: https://google.github.io/styleguide/shellguide.html
[chrome-bash]: https://chromium.googlesource.com/chromiumos/docs/+/HEAD/styleguide/shell.md
[apple-bash]: https://developer.apple.com/library/archive/documentation/OpenSource/Conceptual/ShellScripting/Introduction/Introduction.html
[poshcode]: https://github.com/PoshCode/PowerShellPracticeAndStyle

### Influences and Inspiration

* The DNS automation is heavily inspired by how the [US Government manages DNS][18f-dns].

### Decision Log

* Terraform + AWS because it's boring. I'm familiar with both of these technologies already. Thanks
  @jezhumble for this sharing how the [US Government manages DNS][18f-dns]
* `s3` backend for Terraform state because I repave frequently so need to ensure these files are
  stored somewhere safe.
* Separate `terraform` user created with: `IAMFullAccess`, `AmazonS3FullAccess`, and `AmazonRoute53FullAccess`
  policies. Created manually as I wasn't sure how to `terraform` the user that `terraform` runs as. Never used
  the **Access Advisor** before and it's pretty slick! (looks like I should have a [bootstrap][tf-bootstrap])
* Still using Terraform but no longer going to use AWS DNS. No need for the level of indirection. Gandi.net
  works just fine.
* Moved to storing infrastructure related secrets in this repository and securing them
  using `git-crypt`.
* Abandoned the decision log since I don't maintain or update it.

[18f-dns]: https://18f.gsa.gov/2018/08/15/shared-infrastructure-as-code/
[tf-bootstrap]: https://github.com/18F/dns/blob/master/terraform/bootstrap/init.tf
