
import { Context } from './Context'


class IsEvenError extends Error {

  isIsEvenError = true

  sdk = 'IsEven'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  IsEvenError
}

