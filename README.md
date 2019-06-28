# Reasoning API Framework

A tool to rapidly model contract rules and expose them as APIs for integration with conversational agents.

![Editor](resources/editor.png?raw=true "Editor")

## Description

This code was developed by the [AXA REV research team](https://axa-rev-research.github.io/) to serve as prototype to rapidly model contract rules and expose them as APIs for integration with conversational agents.

Main features:

- Intuitive, [mxGraph](https://github.com/jgraph/mxgraph) powered user interface to model contract rules (statements)
- Easy API url setup and instant data updates
- Built-in error prevention based on the quality engineering principle of [poka-yoke](https://en.wikipedia.org/wiki/Poka-yoke)
- Multi-tenancy: Operate APIs for multiple contracts within one framework
- User authentication using [Devise](https://github.com/plataformatec/devise) and role-based user authorization using [cancancan](https://github.com/CanCanCommunity/cancancan)

## Setup

### 0. Requirements
- Ruby 2.4.1+
- [bundler](https://bundler.io/), `gem install bundler`
- A database, e.g. MySQL, PostgreSQL, Oracle

### 1. Web application

Clone the respository and install the required gems:
```
bundle install
```

Generate secret keys for the `development` and `test` sections in [config/secrets.yml](config/secrets.yml):

```
rake secret
```

Create the database and load the schema:
```
rake db:setup
```

Open the Rails console with `rails c` and create your admin account: 
```
User.create(email: "name@domain.com", password: "TOPSECRET_PASSWORD", password_confirmation: "TOPSECRET_PASSWORD", role: "admin")
```
Startup your local web server:
```
rails s
```
Login in at http://localhost:3000 and create your first Reasoning API.

## Contact

For questions, please contact boris.ruf@axa.com.

## MIT License

Copyright (c) GIE AXA Services France SAS

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
