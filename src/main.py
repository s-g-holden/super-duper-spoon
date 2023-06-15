import datetime
import pytz
import json
import logging
import os

logger = logging.getLogger()
logger.setLevel(logging.DEBUG)

def handler(event, context):
    logger.debug(f"Received event: {json.dumps(event)}")
    
    try:
        country_code = os.environ.get('COUNTRY_CODE')

        if country_code:
            capital_timezone = pytz.country_timezones[country_code][0]
            logger.info(f"Successfully retrieved timezone {capital_timezone} for country code {country_code}")

            current_time = datetime.datetime.now(pytz.timezone(capital_timezone))

            time_str = current_time.strftime('%Y-%m-%d %H:%M:%S %Z%z')

            response = {
                'statusCode': 200,
                'body': json.dumps({'message': f'The current time in {country_code} capital is: {time_str}'})
            }
            logger.info(f"Successfully returned response: {response}")
        else:
            response = {
                'statusCode': 400,
                'body': json.dumps({'message': 'Missing country code environment variable'})
            }
            logger.error("Failed to retrieve country code from environment variable")
    except Exception as e:
        response = {
            'statusCode': 500,
            'body': json.dumps({'message': f'Error: {str(e)}'})
        }
        logger.error(f"An error occurred: {str(e)}")

    return response
