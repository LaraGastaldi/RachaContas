import { TestBed } from '@angular/core/testing';

import { UserToDebtService } from './user-to-debt.service';

describe('UserToDebtService', () => {
  let service: UserToDebtService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(UserToDebtService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
