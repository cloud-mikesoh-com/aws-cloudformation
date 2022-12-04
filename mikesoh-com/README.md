# mikesoh.com Deployments

## ec2/networking/rds 

More to come.

## SES

[Understanding AWS's SES Receive Rules concepts](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-concepts.html) are critical to understanding how the rule-set works.  There are a total of three rules within the rule-set the define how an email is routed.

```mermaid
flowchart TD
    Node0((Email Received)) --> A1{Is the email address 'active'?}
    subgraph Active Alias rule
        A1 --> |No| A2[Return Bounce Response]
        A2 --> Astop(STOP RULE SET)
        A1 --> |Yes| A3[Stop processing current rule]
    end

    subgraph Ignore Alias rule
        A3 --> B1{Is the 'Ignore' flag set?}
        B1 --> |Yes| Bstop([STOP RULE SET])
        B1 --> |No| B3[Email is Deliverable]
        B3 --> B4[Stop processing current rule]
    end

    subgraph Deliver Email
        B4 --> C1[Deliver to S3]
        C1 --> Cstop([STOP RULE SET])
    end
    
    class Astop,Bstop,Cstop stopNode;
    classDef stopNode fill: #F8CECC
    style C1 fill: #D5E8D4
```

The rule-set provides an initial "deny".  Once delivered to S3, a lambda then pipes to [procmail](https://manpages.ubuntu.com/manpages/trusty/man1/procmail.1.html) for further processing.  At that point, emails are not bounced using SES's native bounce template.

