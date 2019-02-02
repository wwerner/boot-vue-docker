package net.wolfgangwerner.examples.bvd.api;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * Just an example HTTP endpoint
 */
@Controller
public class GreetingEndpoint {

    /**
     * Just a simple test to see if the service is up. Says hi.
     *
     * @param name String
     *        The name of the person to greet.
     * @return String a greeting.
     */
    @RequestMapping(value = "/api/greeting", method = RequestMethod.GET, produces = MediaType.TEXT_PLAIN_VALUE)
    public ResponseEntity<String> greeting(@RequestParam(value="name", required=false) String name) {
        if (name == null)
            return ResponseEntity.badRequest().body("I need someone to say hi to. Use ?name= ...");
        return ResponseEntity.ok("Hello " + name);
    }

}
