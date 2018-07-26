const gql = require('graphql-tag')
const createApolloClient = require('./create-apollo-client')

require('browser-env')()
window.WebSocket = require('isomorphic-ws')

const ActionCable = require('actioncable')

exports.AppClient = class AppClient {
  constructor (options = {}) {
    const { token } = options
    const cable = this.cable = ActionCable.createConsumer(`${process.env.WEBSOCKETS_ENDPOINT}/cable?access_token=${token}`)
    this.client = createApolloClient({ token, cable, endpoint: `${process.env.API_ENDPOINT}/graphql` })
    this.mutate = this.client.mutate.bind(this.client)
    this.query = this.client.query.bind(this.client)
    this.subscribe = this.client.subscribe.bind(this.client)
  }

  authenticate ({ identity }) {
    return this.mutate({ variables: { identity },
      mutation: gql`mutation Authenticate($identity: IdentityInput!) {
      authenticate(identity: $identity) { accessToken user { id, name } } }` })
  }

  register ({ identity }) {
    return this.mutate({ variables: { identity }, mutation: gql`mutation Register($identity: IdentityInput!) {
      register(identity: $identity) {
        accessToken
        user { id, name }
      }
    }
    ` })
  }

  createTask ({ task, taskLists }) {
    return this.mutate({ variables: { task, taskLists },
      mutation: gql`mutation TasksCreate($task: TaskInput!, $taskLists: [ID!]) {
        tasksCreate(task: $task, taskLists: $taskLists) {
          task { id, title, description } }
      }` })
  }

  createTaskList (taskList) {
    return this.mutate({ variables: { taskList },
      mutation: gql`mutation TaskListCreate($taskList: TaskListInput!) {
        taskListCreate(taskList: $taskList) { taskList { id, name } }
      }` })
  }
}
