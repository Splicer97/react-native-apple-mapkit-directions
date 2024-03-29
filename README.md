# react-native-apple-mapkit-directions [![npm version](https://img.shields.io/npm/v/react-native-apple-mapkit-directions.svg?style=flat)](https://www.npmjs.com/package/react-native-apple-mapkit-directions) [![Downloads](https://img.shields.io/npm/dm/react-native-apple-mapkit-directions.svg)](http://www.npmtrends.com/react-native-apple-mapkit-directions)

React Native wrapper for Apple MapKit Directions.
You can get distance, expectedTravelTime, name, advisoryNotices or coordinates.
Work ONLY for IOS!

## Installation

```sh
npm install react-native-apple-mapkit-directions
```

or

```sh
yarn add react-native-apple-mapkit-directions
```

then install pod

```sh
cd ios && pod install
```

## Usage

```js
import {
  getAppleMapKitDirections,
  MapKitTransit,
} from 'react-native-apple-mapkit-directions';

// ...
const origin = {
  latitude: 55.751244,
  longitude: 37.618423,
};
const destination = {
  latitude: 59.9375,
  longitude: 30.308611,
};
const transitType = MapKitTransit.AUTOMOBILE;
const points = await getAppleMapKitDirections(origin, destination, transitType);
```

You can use it with react-native-maps

```js
import * as React from 'react';

import { StyleSheet } from 'react-native';
import MapView, { LatLng, Polyline } from 'react-native-maps';
import {
  getAppleMapKitDirections,
  MapKitTransit,
} from 'react-native-apple-mapkit-directions';

export default function App() {
  const styles = StyleSheet.create({
    map: {
      ...StyleSheet.absoluteFillObject,
    },
  });
  const origin = {
    latitude: 55.751244,
    longitude: 37.618423,
  };
  const destination = {
    latitude: 59.9375,
    longitude: 30.308611,
  };
  const transitType = MapKitTransit.AUTOMOBILE;
  const [state, setState] = React.useState<LatLng[]>();
  React.useEffect(() => {
    const getPoints = async () => {
      if (Platform.OS === 'ios') {
        try {
          const points = await getAppleMapKitDirections(
            origin,
            destination,
            transitType
          );
          setState(points.coordinates);
        } catch (error) {
          console.log('error', error);
        }
      }
    };
    getPoints();
  }, []);

  return (
    <MapView style={styles.map}>
      {state && <Polyline coordinates={state} />}
    </MapView>
  );
}

```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
