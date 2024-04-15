const dice = require("./index");
test("Returns a random number between 1 and 6", () => {
    const rollResult = dice.roll();
    console.log(`result was ${rollResult}`);
    expect(rollResult).toBeGreaterThanOrEqual(1);
    expect(rollResult).toBeLessThanOrEqual(6);
});