import { AppComponent } from './app.component';

describe('AppComponent', () => {
  it('should create the app', () => {
    const component = new AppComponent();
    expect(component).toBeTruthy();
  });

  it(`should have the 'sample-angular-app' title`, () => {
    const component = new AppComponent();
    expect(component.title).toEqual('sample-angular-app');
  });
});
