# Personal Infratstructure

### DNS



### Decision Log

* Terraform + AWS because it's boring. I'm familiar with both of these technologies already. Thanks
  @jezhumble for this sharing how the [US Government manages DNS][18f-dns]
* `s3` backend for Terraform state because I repave frequently so need to ensure these files are
  stored somewhere safe.

[18f-dns]: https://18f.gsa.gov/2018/08/15/shared-infrastructure-as-code/