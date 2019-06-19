# Simple S3 Resource for [Concourse CI](http://concourse.ci)

Resource to upload files to S3. Unlike the [the official S3 Resource](https://github.com/concourse/s3-resource), this Resource can upload or download multiple files.

According `awscli` [description](https://pypi.org/project/awscli/), Using docker on Python 3.7.3.

Docker assets files create through [link](https://concourse-ci.org/implementing-resource-types.html).

## Usage

Include the following in your Pipeline YAML file, replacing the values in the angle brackets (`< >`):

```yaml
resource_types:
- name: <resource type name>
  type: docker-image
  source:
    repository: maomishen/s3-resource-simple
resources:
- name: <resource name>
  type: <resource type name>
  source:
    access_key_id: {{aws-access-key}}
    secret_access_key: {{aws-secret-key}}
    bucket: {{aws-bucket}}
    archive: [<optional>, archive build json file, default is 'finished' folder]
    moveto: [<optional>, move downloaded file to other folder on s3, default is 'building' folder]
    outpath: [<optional, same as yml file's outputs value>]
    options: [<optional, see note below>]
    region: <optional, see below>
    path: [<optional, default is root folder>]
    fetch: [<optional, download files, default is "true">]
    logpath: [<optional>, upload log files to s3, local path]
    s3logpath: [<optional>, log folder on s3, default is 'log' folder]
jobs:
- name: <job name>
  plan:
  - <some Resource or Task that outputs files>
  - put: <resource name>
```

## AWS Credentials

The `access_key_id` and `secret_access_key` are optional and if not provided the EC2 Metadata service will be queried for role based credentials.

## Options

The `options` parameter is synonymous with the options that `aws cli` accepts for `sync`. Please see [S3 Sync Options](http://docs.aws.amazon.com/cli/latest/reference/s3/sync.html#options) and pay special attention to the [Use of Exclude and Include Filters](http://docs.aws.amazon.com/cli/latest/reference/s3/index.html#use-of-exclude-and-include-filters).

Given the following directory `test`:

```
test
├── results
│   ├── 1.json
│   └── 2.json
└── scripts
    └── bad.sh
```

we can upload _only_ the `results` subdirectory by using the following `options` in our task configuration:

```yaml
options:
- "--exclude '*'"
- "--include 'results/*'"
```

### Region
Interacting with some AWS regions (like London) requires AWS Signature Version
4. This options allows you to explicitly specify region where your bucket is
located (if this is set, AWS_DEFAULT_REGION env variable will be set accordingly).

```yaml
region: eu-west-2
```
