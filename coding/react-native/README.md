# React Native with Expo

## Install Expo

```bash
npm install -g expo-cli
```

## Create a new project

```bash
npx create-expo-app {{project_name}} --template
```

## Install ESLint

```bash
npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
npm init @eslint/config@latest
npx eslint --inspect-config
```

### .eslintrc.json

```json
{
  "root": true,
  "ignorePatterns": [
    "**/*"
  ],
  "plugins": [
    "@nx"
  ],
  "overrides": [
    {
      "files": [
        "*.ts",
        "*.tsx",
        "*.js",
        "*.jsx"
      ],
      "rules": {
        "@nx/enforce-module-boundaries": [
          "error",
          {
            "enforceBuildableLibDependency": true,
            "allow": [],
            "depConstraints": [
              {
                "sourceTag": "*",
                "onlyDependOnLibsWithTags": [
                  "*"
                ]
              }
            ]
          }
        ]
      }
    },
    {
      "files": [
        "*.ts",
        "*.tsx"
      ],
      "extends": [
        "plugin:@nx/typescript"
      ],
      "rules": {
        "@typescript-eslint/no-extra-semi": "error",
        "no-extra-semi": "off"
      }
    },
    {
      "files": [
        "*.js",
        "*.jsx"
      ],
      "extends": [
        "plugin:@nx/javascript"
      ],
      "rules": {
        "@typescript-eslint/no-extra-semi": "error",
        "no-extra-semi": "off"
      }
    },
    {
      "files": [
        "*.spec.ts",
        "*.spec.tsx",
        "*.spec.js",
        "*.spec.jsx"
      ],
      "env": {
        "jest": true
      },
      "rules": {}
    }
  ]
}
```

### tsconfig.json

```json
{
  "extends": "expo/tsconfig.base",
  "compilerOptions": {
    "strict": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  }
}
```

## Run the project

```bash
cd {{project_name}}
npx expo start
```
