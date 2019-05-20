describe('Google', () => {
  it('should be able to search for terms', () => {
    cy.visit('/')

    cy.get('input[name=q]')
      .type('javascript cypress')

    cy.contains('Google Search')
      .click()

    cy.location('pathname')
      .should('contain', '/search')
  })
})