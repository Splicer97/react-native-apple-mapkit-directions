import { NativeModules } from 'react-native';

const { AppleMapkitDirections } = NativeModules;

export type MapKitTransitType = 'automobile' | 'walking' | 'transit' | 'any';

export enum MapKitTransit {
  AUTOMOBILE = 'automobile',
  WALKING = 'walking',
  TRANSIT = 'transit',
  ANY = 'any',
}

export type LatLng = { latitude: number; longitude: number };
export type MapKitDirectionsType = {
  distance: number;
  expectedTravelTime: number;
  name: string;
  advisoryNotices: string[];
  coordinates: LatLng[];
};

export const getAppleMapKitDirections = (
  origin: LatLng,
  destination: LatLng,
  transitType: MapKitTransitType
): Promise<MapKitDirectionsType> =>
  AppleMapkitDirections.getAppleMapKitDirections(
    origin,
    destination,
    transitType
  );
