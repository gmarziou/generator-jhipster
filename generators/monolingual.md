# Monolingual applications

## Problem

Currently, JHipster can generate only English monolingual applications.
To generate an application that supports only French, you must enable i18n with only one language.
This comes with few drawbacks: 

- templates are less readable
- developer must sync template and JSON translation files
- additional dependency on i18n libraries

## What do we translate?

1. HTML: text in elements body
2. HTML: text in `placeholder` attributes
3. Typescript: text in strings (errors, page titles)

Currently, #2 and #3 are replaced using regular expressions in `generators/utils.js`.
The regex are quite complex but it's easy to use another language than English without modifying the regex.

~~~typescript
    const re = /placeholder=['|"]([{]{2}['|"]([a-zA-Z0-9.\-_]+)['|"][\s][|][\s](translate)[}]{2})['|"]/g;
    const regex = /errorMessage[\s]*:[\s]*['|"]([a-zA-Z0-9.\-_]+)['|"]/g;
    const regex = /pageTitle[\s]*:[\s]*['|"]([a-zA-Z0-9.\-_]+)['|"]/g;
~~~

#1 is more complex because the key of the i18n is defined in the `jhiTranslate` attribute of an element while the text to replace is in its body. Only Angular

~~~html
    <label for="password" jhiTranslate="login.form.password">Password</label>
~~~

So this would require more complex regex.

I propose that the key gets stored in the body of the element using a EJS template

~~~html
    <label for="password" jhiTranslate="login.form.password"><%- t('login.form.password') %></label>
~~~

=== Angular

Currently, we use a directive:

~~~html
    <label for="password" jhiTranslate="login.form.password">Password</label>
~~~

while we could use a pipe:

~~~html
    <label for="password">{{ 'login.form.password' | translate }}</label>
~~~

Angular i18n does not support translations in code, only in templates.

=== React

React does not use HTML templates, so it's covered by #3.

=== Vue

~~~html
~~~
