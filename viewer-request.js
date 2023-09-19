// Basic routing helper to serve the right html file from s3
// assume uri to be like /**/* or /**/*/ that require modification
// modify uri by appending .html so that the right object can be found in s3

function handler(event) {
  const request = event.request;
  const pathSegments = request.uri.split("/");

  //Pop off the last segment if it is empty (trailing slash)
  if (pathSegments[pathSegments.length - 1] === "") {
    pathSegments.pop();
  }

  //Append .html to the last segment if it does not contain a period
  if (pathSegments.length > 0) {
    const lastRoute = pathSegments[pathSegments.length - 1];
    if (
      lastRoute !== "" &&
      !pathSegments[pathSegments.length - 1].includes(".")
    ) {
      pathSegments[pathSegments.length - 1] += ".html";
    }

    //Rebuild the URI and add a leading slash
    let newUri = pathSegments.join("/");
    if (!newUri.startsWith("/")) {
      newUri = "/" + newUri;
    }

    request.uri = newUri;
    return request;
  } else {
    return request;
  }
}
