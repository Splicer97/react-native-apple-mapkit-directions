import * as React from 'react';

import { Text, View } from 'react-native';
import {
  getAppleMapKitDirections,
  LatLng,
  MapKitTransit,
} from 'react-native-apple-mapkit-directions';

export default function App() {
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
      try {
        const points = await getAppleMapKitDirections(
          origin,
          destination,
          transitType
        );
        setState(points?.coordinates);
      } catch (error) {
        console.log('error', error);
      }
    };
    getPoints();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <View>
      <Text>{state}</Text>
    </View>
  );
}
