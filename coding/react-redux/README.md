# React / Redux

```bash
# https://github.com/facebook/create-react-app
npx create-react-app artificial-web --template typescript
npm install --save typescript @types/react @types/react-dom
npm install @reduxjs/toolkit
npx create-react-app my-app --template redux-typescript
npm install redux
npm install react-router-dom
npm install --save @types/react-router-dom

# Create React App doesn’t include any tools for this by default, but you can add Storybook for React
npx -p @storybook/cli sb init
# To run Storybook manually, run npm run storybook. CTRL+C to stop.
npm run storybook

# Install libraries
npm install react-bootstrap
npm install bootstrap
npm install lightweight-charts

# generate typescript model from openapi
brew install openapi-generator
openapi-generator generate -i jarvis-api.yaml --additional-properties allowUnicodeIdentifiers=true,prependFormOrBodyParameters=true,modelPropertyNaming=original,supportsES6=true -g typescript-fetch -o ./src/modules/jarvis-api/

# React / Redux
# It used to be very complicated with action, reducer, store management but now can achieve easily with slides

# Use RTK api generator
npm i @rtk-query/codegen-openapi
npm install --save-dev esbuild-runner
npx @rtk-query/codegen-openapi openapi-config.ts

# https://tailwindcss.com/docs/installation
# https://preline.co/docs/input.html
npm install tailwindcss-opentype
# https://github.com/tailwindlabs/tailwindcss-forms
npm install -D @tailwindcss/forms

# Cookie management
npm install js-cookie
npm install @types/js-cookie
```

```typescript
import React, { useEffect } from 'react';
import Cookies from 'js-cookie';

function MyComponent() {
    useEffect(() => {
        // Set a cookie
        Cookies.set('myCookie', 'cookieValue', { expires: 7 });

        // Get a cookie
        const myCookieValue = Cookies.get('myCookie');
        console.log(myCookieValue);
    }, []);

    // ...
}

// To prevent react router always refreshing whole page, use Link instead of <a href="..."></a>
// https://www.npmjs.com/package/tailwind-datepicker-react
```

![Screenshot 2023-12-07 at 10 13 45 AM](https://github.com/user-attachments/assets/f7ff28db-42eb-4c35-b77d-55bedf219734)

