Caltrain Delays
================

Overview
--------

[Caltrain](http://caltrain.com) is a commuter rail line that serves the San Francisco Peninsula. It serves about 65,000 riders per week day over it's 77-mile route, and has an operating budget just shy of $150 million.

Caltrain [defines on-time arrivals](http://www.caltrain.com/Assets/__Agendas+and+Minutes/JPB/2018/2018-12-06+Rail+Safety+Presentation.pdf) by comparing scheduled arrival times to actual arrival times at end-line locations (San Francisco 4th and King, San Jose Diridon, Tamien, or Gilroy stations). It has a stated goal of 95 percent on-time at end-line locations, defined at reaching the final destination no more than 6 minutes from the scheduled arrival time. By this metric, Caltrain's on-time performance (OTP) is about 93 percent.

Caltrain is primarily used by weekday commuters. Weekend ridership is about 85 percent less than weekday ridership, and the fullest trains in both directions operate during weekday commute hours (5-9AM and 3-7PM). Because of this, Caltrain's OTP metrics give an incomplete picture of reliability for most riders.

Caltrain operates a [twitter account](https://twitter.com/Caltrain) that provides "news, major service impacts & answers between 7am and 7pm" on weekdays. Data were gathered from this account and aggregated as shown in the methodology below.

Results
-------

<img src="R01_markdown_attempt1_files/figure-markdown_github/show figures-1.png" width="\textwidth" style="display: block; margin: auto;" /><img src="R01_markdown_attempt1_files/figure-markdown_github/show figures-2.png" width="\textwidth" style="display: block; margin: auto;" /><img src="R01_markdown_attempt1_files/figure-markdown_github/show figures-3.png" width="\textwidth" style="display: block; margin: auto;" /><img src="R01_markdown_attempt1_files/figure-markdown_github/show figures-4.png" width="\textwidth" style="display: block; margin: auto;" />

<em>Notes:</em> Data on delays from Caltrain twitter account. A delay is defined by the announcement of delays in a tweet for any train and any station, and a major delay is defined as at least 20 minutes behind schedule. Morning commute is defined as 7-9AM, and evening commute as 3-7PM.

Methodology
-----------

Data were pulled from the Caltrain twitter account using the [rtweet](https://rtweet.info/index.html) package. This package uses the Twitter API to gather up to 3200 tweets on a user's timeline. Data were collected starting on 2018-09-19. Replies were removed, and all tweets not during commute hours (7-9AM and 3-7PM) were dropped. All weekend tweets were dropped as well.

Tweets were aggregated by date and commute (morning/evening), such that each date had two commutes even if the account did not tweet during those times on a given day. A delay tweet was defined by mentioning the word "delay", "delayed", or a mention of -XX, where XX is a pair of integers. The latter definition is to capture the accounts shorthand for delay times (e.g. NB278 -15" departing MVW indicates that north bound train 257 is 15 minutes late departing the Mountain View station). A major delay is indicated by a delay of 20 minutes or more. Data were collapsed to record whether any tweets during commute times indicated a delay, and if so, whether there was a major delay.
