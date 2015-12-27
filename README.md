# rakam-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['rakam']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### rakam::default

Include `rakam` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[rakam::default]"
  ]
}
```

## License and Authors

Author:: Burak Emre Kabakcı (<emrekabakci@gmail.com>)
