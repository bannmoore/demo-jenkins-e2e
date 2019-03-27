const { expect } = require('chai')

describe('Functional Tests', function () {
  it('should run a functional test', function () {
    expect(process.env.SUITE).to.equal('functional')
  })
})