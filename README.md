### SignalWire Coding Challenge

This challenge is designed to be representational of the type of functionality we often do at SignalWire. The challenge should ideally not take longer than 1 hour to implement.

The challenge is to build an API route, that accepts a JSON payload that looks like:

```json
{
  "user_id" : 1234,
  "title" : "My title",
  "tags" : ["tag1", "tag2"]
}
```

* The route should validate that `user_id` and `title` are present, `tags` can be empty, but must also be fewer than 5.
* If valid, the request should:
  * Store the `user_id` and `title` in a table named `tickets`, along with the datetime it was received.
  * Keep a running count of all the case-insensitive tags received in a table named `tags`.
  * Send a webhook request to a URL containing the tag with current highest count. No specific requirements, just be sure to include the tag in the request query string or body. Feel free to use a website like https://webhook.site/ to send the request to.
* If invalid, the request should: 
  * respond with a 422 and a JSON payload explaining the validation errors.

You SHOULD:
* Provide a working, runnable Rails application that accepts requests on port 3000.
* Provide specs that test the above behaviour.
* Use any gems or libraries you want.
* Deliver via a git repository, zip file, gist.

You SHOULD NOT:
* Worry about UI
* Worry about authentication or authorization
* Configuring the Rails application, security, environments, etc.

Feel free to reach out if you have any questions!
