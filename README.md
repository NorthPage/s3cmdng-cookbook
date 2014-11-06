#s3cmdng-cookbook

An improved cookbook to manage s3cmd.  I borrowed from the `amazon_s3cmd` cookbook.

This cookbook does not allow you to specify an encrypted data bag secret, instead relying on the configured secret.  (`Chef::Config[:encrypted_data_bag_secret]`)

## Supported Platforms

* Ubuntu 14.x
* Centos 6.x
 
## Attributes

* `node['s3cmdng']['users']`: an array of users which will get the s3cmd configuration (default: ['root'])
* `node['s3cmdng']['data_bag_name']`: the encrypted data bag to find AWS creds (default: 's3cmd')
* `node['s3cmdng']['data_bag_item']`: the encrypted data bag item to find AWS creds (default: 's3cfg')

## Usage

### s3cmdng::default

Include `s3cmdng` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[s3cmdng::default]"
  ]
}
```

### Data Bags

`s3cmdng` requires an encrypted data bag with the following format:

```json
{
  "id": "s3cfg",
  "s3_access_key": "ACCESS-KEY",
  "s3_secret_key": "SECRET-ACCESS-KEY"
}
```

## License and Authors

Author:: E Camden Fisher (<camden@northpage.com>)
Copyright (C) 2014 NorthPage

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
