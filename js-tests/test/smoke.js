const { expect } = require('chai')

describe('Smoke Tests', function () {
  it('should run a smoke test', function () {
    expect(process.env.SUITE).to.equal('smoke')
  })
})