*** Test Cases ***
Hello World
    Log    Hello World!

Ignored Failure
    Run Keyword And Ignore Error    Should Be Equal As Strings    Not    Really

Real Failure
    Fail    Oops

Ignore Failure via TRY/EXCEPT
    TRY
        Should Be Equal As Strings    nope    still
    EXCEPT
        Log    Caught exception... continuing
    END
