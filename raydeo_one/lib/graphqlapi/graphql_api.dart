import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class GraphqlServices {
  createChannel(name, loc, url) async {
    print("name$name");
    print("loc$loc");
    print("url$url");
    try {
      var operation = await Amplify.API.query(
        request: GraphQLRequest<String>(
            document: '''mutation CreateChannel(\$input: CreateChannelInput) {
    CreateChannel(input: \$input) {
      status
      status_message
      __typename
    }
  }
   ''',
            variables: {
              'input': {
                'channel_name': '$name',
                'channel_stream_url': '$url',
                'channel_location': '$loc',
              }
            }),
      );
      var response = await operation.response;
      print('Mutation result:${response}');
      var data = response.data;
      var errors = response.errors;
      print('Mutation result:${data}');
    } catch (e) {
      print('error:$e');
    }
  }
}
