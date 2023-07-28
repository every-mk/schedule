import applyCaseMiddleware from "axios-case-converter"
import axios from "axios"

const options = {
  // axiosで受け取った値は変換しない.
  ignoreHeaders: true,
}

const client = applyCaseMiddleware(axios.create({
  baseURL: "http://localhost:3001/api/v1"
}), options)

export default client
