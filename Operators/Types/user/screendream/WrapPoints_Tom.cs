using T3.Core.Operator;
using T3.Core.Operator.Attributes;
using T3.Core.Operator.Slots;

namespace T3.Operators.Types.Id_37afc4dc_183b_4f30_8c5f_e6e2cf12a3b4
{
    public class WrapPoints_Tom : Instance<WrapPoints_Tom>
    {

        [Output(Guid = "5f7f87db-6181-4c4e-90f0-f8dc18f51ebc")]
        public readonly Slot<T3.Core.DataTypes.BufferWithViews> Output = new();

        [Input(Guid = "1c556700-94e7-4bcd-9895-a8e9b5ef017f")]
        public readonly InputSlot<T3.Core.DataTypes.BufferWithViews> Points = new();

        [Input(Guid = "e3b16bcc-628c-48a5-acba-76ecaf958571", MappedType = typeof(FieldModes))]
        public readonly InputSlot<int> FieldMode = new InputSlot<int>();

        [Input(Guid = "b8502e04-81d6-4654-b254-7b8c0a53f238")]
        public readonly InputSlot<System.Numerics.Vector3> Position = new();

        [Input(Guid = "c127fd93-31dd-4bb1-b528-bb4c79028aee")]
        public readonly InputSlot<System.Numerics.Vector3> Size = new();

        [Input(Guid = "6e4ec406-8fac-4f5b-be54-40efa21c341f", MappedType = typeof(Methods))]
        public readonly InputSlot<int> WrapMode = new InputSlot<int>();

        private enum FieldModes
        {
            Box,
            Sphere,
        }
        private enum Methods
        {
            Wrap,
            Clamp,
            Mirror
        }
    }
}

