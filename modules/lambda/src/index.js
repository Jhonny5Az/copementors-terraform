const { S3Client } = require('@aws-sdk/client-s3');
const { getSignedUrl } = require('@aws-sdk/s3-request-presigner');
const { PutObjectCommand } = require('@aws-sdk/client-s3');

const REGION = process.env.AWS_REGION; // Your AWS region
const BUCKET_NAME = 'copetests3-001'; // Replace with your bucket name
const URL_EXPIRATION_SECONDS = 300; // URL expiration time in seconds

// Create an S3 client
const s3Client = new S3Client({ region: REGION });

// Main function to get the upload URL
exports.handler = async (event) => {
  return await getUploadURL(event);
};

const getUploadURL = async (event) => {
  const randomID = Math.floor(Math.random() * 10000000);
  const Key = `${randomID}.jpeg`; // Random filename we will use when uploading files

  // Create the command for the S3 PutObject operation
  const command = new PutObjectCommand({
    Bucket: BUCKET_NAME,
    Key,
    ContentType: 'image/jpeg', // Change this to the media type of the files you want to upload
  });

  try {
    // Generate the pre-signed URL
    const uploadURL = await getSignedUrl(s3Client, command, { expiresIn: URL_EXPIRATION_SECONDS });

    return {
      statusCode: 200,
      isBase64Encoded: false,
      headers: {
        "Access-Control-Allow-Origin": "*"
      },
      body: JSON.stringify({
        uploadURL: uploadURL,
        filename: Key
      })
    };
  } catch (error) {
    console.error('Error getting signed URL', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Could not generate signed URL' })
    };
  }
};