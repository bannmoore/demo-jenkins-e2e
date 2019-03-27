const { expect } = require('chai')

describe('UI Tests', function () {
  it('should run a ui test', function () {
    expect(process.env.SUITE).to.equal('ui')
  })
})