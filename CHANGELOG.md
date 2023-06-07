All notable changes to this terraform will be documented in this file.

# [1.0.0](https://github.com/BorisLabs/terraform-aws-transit-gateway/compare/v0.0.1...v1.0.0) (2023-06-07)


### Bug Fixes

* Add tags to VPC attachment resource ([ffb2a74](https://github.com/BorisLabs/terraform-aws-transit-gateway/commit/ffb2a741e75ec56071e07c11aea07ee691620c8e))
* Added release file ([fbdcb78](https://github.com/BorisLabs/terraform-aws-transit-gateway/commit/fbdcb78e5f9018d8772f5bdd704bf58cc6d409ac))
* Allow adding prefix lists to TGW route table ([5a2032a](https://github.com/BorisLabs/terraform-aws-transit-gateway/commit/5a2032acf31f9882914366b6fdecf4a87c3ff0d5))
* Increase TF required version and pin to AWS provider v4 ([7ae279c](https://github.com/BorisLabs/terraform-aws-transit-gateway/commit/7ae279ca75dd1c2fc4909adecaf7f02169439e9b))
* release file rename ([7925dff](https://github.com/BorisLabs/terraform-aws-transit-gateway/commit/7925dfff74b37d6a77e3ea18888baebe63dcbdf6))


* Merge pull request #6 from BorisLabs/remove-providers-file ([db85290](https://github.com/BorisLabs/terraform-aws-transit-gateway/commit/db852908fbef49ae0203ef0af3c19a811d66792f)), closes [#6](https://github.com/BorisLabs/terraform-aws-transit-gateway/issues/6)


### BREAKING CHANGES

* remove providers.tf as it conflicts with terragrunt,…
