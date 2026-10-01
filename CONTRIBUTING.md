# Contributing

Thanks for helping improve NiceShot.

Please keep contributions aligned with the project's core constraints:

- use macOS built-ins and free, open-source software only;
- do not add a third-party screenshot application;
- clipboard-only shortcuts must not create temporary image files;
- do not upload screenshots or telemetry;
- do not change SIP, Gatekeeper, or system security policies;
- preserve unrelated Karabiner rules and back up before writing configuration.

Before opening a pull request, validate the JSON and Ruby files:

```zsh
ruby -rjson -e 'JSON.parse(File.read("karabiner/rule.template.json")); puts "JSON OK"'
ruby -c scripts/install.rb
ruby -c scripts/uninstall.rb
```

