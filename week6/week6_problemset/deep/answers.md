# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

The biggest reason in favor of random partitioning is that all three boats will share the load of data roughly equally.
However, there is no intrinsic organization of the data. Hence, queries will be slower as all three boats will need to be queried for any given condition.

## Partitioning by Hour

The biggest reason in favor of partitioning by hour is that the data will be naturally sorted based on when it was collected. This would make querying the data by timestamp much easier. However, due to the uneven schedule of AquaByte's data collection, most of the data will be concentrated on one boat.

## Partitioning by Hash Value

Partitioning via hash value is somewhat of a middle ground between the other two options. Data will be stored evenly on the boats and there is a system outside of pure randomness for that storage. This will make specific queries easier when the hash value for a timestamp is known. However, since the hash values are initially arbitrary, querying a range of data will still need to be done across all boats.
