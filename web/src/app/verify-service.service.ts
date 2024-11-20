import { Injectable } from '@angular/core';
import { ajax } from 'rxjs/ajax';
import { environment } from '../environments/environment.development';
import { catchError, map } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class VerifyService {

  constructor() { }

  verify(id: string|null) {
    return ajax({
      url: `${environment.apiUrl}/verify/${id}`,
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    }).pipe(
      map(res => res.response),
      catchError(err => {
        throw new Error(err.response);
      })
    );
  }
}
