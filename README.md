# dakauf_spec_generator

A webapp for generating product specification for dakauf.eu

👉See Live App: [LIVE](https://www.csonah.com)

### Screenshot

<p align="center">
<img height="567" src="https://github.com/cs-onah/dakauf_spec_generator/blob/main/docs/image.png" alt="Loading photo" loading="eager">
</p>

### About

The app converts user input to a specific json format. See sample output below

## Sample Json:
```json
[
    {
        "name": "Network",
        "attributes": [
            {
                "name": "Technology",
                "value": "GSM \\/ HSPA \\/ LTE \\/ 5G"
            },
            {
                "name": "2G Bands",
                "value": "GSM 850 \\/ 900 \\/ 1800 \\/ 1900"
            }
        ]
    },
    {
        "name": "Body",
        "attributes": [
            {
                "name": "Dimensions",
                "value": "326.4 x 208.6 x 5.4 mm (12.85 x 8.21 x 0.21 in)"
            },
            {
                "name": "Build",
                "value": "Glass front, aluminum frame, aluminum back"
            }
        ]
    }
]
```
