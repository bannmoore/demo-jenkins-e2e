const { expect } = require('chai')

describe('Functional Tests', function () {
  it('should check something', function () {
    expect(1).to.equal(1)
  });

  describe('Doing a thing', function () {
    it('should run a functional test', function () {
      expect(process.env.SUITE).to.equal('functional')
    })

    it('should fail', function () {
      expect(1).not.to.equal(1);
    })
  })
})