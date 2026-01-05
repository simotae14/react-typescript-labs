import React from 'react';

import { Card } from '$/common/components/card';
import { Button } from './button';

type CounterFormProps = {
  onSubmit: React.FormEventHandler<HTMLFormElement>;
};

const CounterForm = ({ onSubmit }: CounterFormProps) => {
  const [draftCount, setDraftCount] = React.useState(0);

  const handleSubmit: React.ChangeEventHandler<HTMLInputElement> = (e) =>
    setDraftCount(e.target.valueAsNumber);
  return (
    <form className="flex items-center gap-2" onSubmit={onSubmit}>
      <input
        className="ring-primary-600 focus:border-primary-800 rounded border border-slate-500 px-4 py-2 outline-none focus:ring-2"
        type="number"
        onChange={handleSubmit}
        value={draftCount}
        name="count"
      />
      <Button>Update Counter</Button>
    </form>
  );
};

type CounterControlsProps = {
  count: number;
  setCount: React.Dispatch<React.SetStateAction<number>>;
};

const CounterControls = ({ count, setCount }: CounterControlsProps) => {
  return (
    <div className="flex gap-2">
      <button onClick={() => setCount((prev) => prev - 1)}>➖ Decrement</button>
      <button onClick={() => setCount(0)}>🔁 Reset</button>
      <button onClick={() => setCount(count + 1)}>➕ Increment</button>
    </div>
  );
};

export const Counter = () => {
  const [count, setCount] = React.useState(0);

  return (
    <Card className="border-primary-500 flex w-2/3 flex-col items-center gap-8">
      <h1>Days Since the Last Accident</h1>
      <p className="text-6xl">{count}</p>
      <CounterControls count={count} setCount={setCount} />
      <CounterForm
        onSubmit={(e) => {
          e.preventDefault();

          const formData = new FormData(e.currentTarget);
          const newCount = Number(formData.get('count'));

          setCount(newCount);
        }}
      />
    </Card>
  );
};
