# tobike_chart

This is a simple tool to download the Tobike bike list and plot them.

## Usage

```bash
$ ./pipeline.sh
```

This bash script will automatically perform all the operations, with a download time interval set a 30 mins.
To obtain an optimal outcome, the script should run in the background for min 3 days, in order to obtain enough data.

The bike status plots represent the change in the number of present bikes at a specific station during the day,
with a 30 min step interval.
