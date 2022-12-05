# TrainsTest

Notes:
Project took aprox 8 hours to complete.
All tasks complete, though the design is lacking :D

Issues:
- Not thread managment at all. It's an optimistic build.
- No error handling.
- Overall kinda ugly but IDK, I like it when tests look like tests.
- Occaionally I get inconsistent data, decided not to investigate since it's been 8 hours for a take home test.
- Task description said not to use frameworks but I assumed visual frameworks are ok (SnapKit) so I used it.
- Also used AlamoFire, this is a wrapped that makes REST API less code, no functionality so I'm assuming it's ok.

Comments:
- I decided to restructure the data into routes/stops which I'm not sure is the more efficiant solution, but it's efficiant enough, there may have been a way to fetch all the data I need without using as many loops (map, filter, forEach, etc.) but I'm used to using data that changes live, making it a necessary part of the process.
- The MBTA api had many features that I didn't use, I only used what I thought I need, there may have been a way to prefetch the exact data I need.
