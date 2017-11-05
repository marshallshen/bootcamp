### Q1

Being a pretty standard Rails application, GitLab is built using the MVC design pattern. Please describe in as much detail as you think is appropriate what the responsibilities of the Model, View, and Controller are, both in general and in Rails specifically, and what the benefits of this separation are. Also touch on how the Concern and Service patterns fit into this.

Model includes the domain objects which reflect the business domain the software is based on. Some major responsibilities of the model include:

1. Map a business domain to database (Object Relational Mapping). In Rails, the ActiveRecord provides many tools to connect model objects to database. Although as the application grows, the application will encounter scaling problems by only using out of the box ActiveRecord APIs.
2. Domain specific logic, including customized getters and setters methods beyond database interaction. Imagine we are developing an online shopping application and we have a model called Order, we might need an instance method called `submit!` to submit an order.

**On concerns**
I learned the benefit of concerns specifically in Rails. I think of it as a “helper” for common functionality across different data model. Imagine if we have two models `Video` and `Image`, and both models can have tags. Therefore we can use concerns to make both class `Taggable`

```ruby
# app/models/concerns/taggable.rb

module Taggable
  extend ActiveSupport::Concern
  included do
     has_many :entity_tags, as: :entity
     has_many :tags, through: 
  end
end

# app/models/video.rb
class Video < Application
  include Taggable
end

# app/models/image.rb
class Image < Application
  include Taggable
end
```

Views are the presentation layer of the the application. Ideally it should not have any logic and has the sole responsibility of rendering visual elements such as DOM. With Rails, we can make the webpage dynamic by including .erb files. However, using only .erb and asset pipeline is hard to build a highly reponsive application. For performance and user experience,  Rails community have been trying to use more dynamic framework such as React and Vue to handle the View layer while having Rails return APIs responses, sometimes formatted with serializer. The benefit of switching to such paradigm is two-folded: for one it allows developers to leverage the power of the framework to build more interactive web app, for another it allows frontend develoepers to work more efficiently without having to wait on the backend work to be complete.

Controllers are the connectors between the models and views. Controllers "routes" web traffic to correct place, and they handle both good and bad traffic. The major responsibilities of the controllers include:

1. handling different requests via the routing rules, in Rails it's `routes.rb`
2. parse the params that come with the request, Rails has `strong_parameters` to help filter allowed and required parameters.
3. Authentication and authorization. They can also be handled at the middleware level before the request actually hits the controller. In Rails, it's common to authenticate a user's access using Gem such as Devise, and/or authorize actions an authenticated user can perform using Gem such as CanCan.

**On services**

Services implement business logic based on the user flow. This pattern comes in handy when we have a feature whose logic is complicated and it feels too much to just put the logic on the model layer (sometimes it requires more than one model!). However, in my personal opinion, service patterns can be overused and I use it with caution. Several things I watch out for:

1. Not to have a service object track too many states
2. Understand which part of the feature must be synchronous, and which part can be asychronous. For the part that can be asychronous, I will think about moving it to jobs layer.
3. Each service has a clear responsiblity of what it does. For example, if a service is "create_invoice", make sure the service only "create_invoice" and nothing else (e.g. don't implement a subroutine to redeem gift code!). This prevents sphagetti code and also allows developers to test the code in isolation.

### Q2

A user browses to https://gitlab.com/gitlab-org/gitlab-ce in their browser. Please describe in as much detail as you think is appropriate the lifecycle of this request and what happens in the browser, over the network, on GitLab servers, and in the GitLab Rails application before the request completes.

The lifecycle of the request

1. browser issues a request to https://gitlab.com/gitlab-org/gitlab-ce, sends it the nearest DNS
2. After tring to find the matching domain across DNS server, the request is routed to the known IP of the load balancer.
3. loader balancer routes the request to one app server with Rails to handle the traffic
4. the app server receives the request, identify the route pattern of the request
5. the app server handles the request by:
    - rendering back the HTML template
    - rendering back the data that can be rendered inside the template
    - rendering the link of compiled assets including CSS, Javascripts, and SVG files etc.. If a CDN is setup, then those assets will be serviced through a CDN link, which was linked whenever the Rails app is deployed. If a CDN is not setup, then those assets will be saved and served under "public/" folder of the app.
6. the browser receives the response packet, parsing the DOM with the assets. If the assets are not there, it will try to fetch the assets first via HTTP.
7. Upon parsing the Javascript, additional AJAX requests are fired to Gitlab endpoints.
8. The Gitlab servers receives the request following the same procedure mentioned in 1-3, then returns the JSON response from the server.


